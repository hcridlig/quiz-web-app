import React from 'react';
import { Button, Typography } from '@mui/material';
import { Button } from 'react-bootstrap';

const Question = ({ question, options, onSelect, selectedOption }) => {
  return (
    <div>
      <Typography variant="h5" gutterBottom>
        {question}
      </Typography>
      {options.map((option, index) => (
        <Button
          key={index}
          variant={selectedOption === option ? 'contained' : 'outlined'}
          color={selectedOption === option ? 'primary' : 'default'}
          onClick={() => onSelect(option)}
        >
          {option}
        </Button>
      ))}
    </div>
  );
};

export default Question;